from flask import Flask, request, send_from_directory
from models import Product, db

app = Flask(__name__)


@app.route("/")
def index():
    return {"message": "Api is running"}


@app.route("/api")
def heartbeat():
    return {"message": "Api is running"}


@app.route('/images/<path:path>')
def send_report(path):
    return send_from_directory('seed_images', path+".jpg")


@app.route("/api/products")
def get_products():
    search_term = request.args.get("search_term")
    category = request.args.get("category")

    q = Product.select()
    if search_term:
        if search_term.isdigit():
            q = q.where(Product.id == search_term)
        else:
            q = q.where(Product.search_content.match(search_term))
    if category:
        q = q.where(Product.category == category)
    else:
        q = q.where(Product.category.is_null(False))

    q = q.limit(10)

    return [product.to_dict() for product in q]


@app.route("/api/products/<int:product_id>")
def get_product(product_id):
    q = Product.select().where(Product.id == product_id)
    if q.exists():
        return q[0].to_dict()
    else:
        return {"message": "not found"}, 404


@app.before_request
def before_request():
    db.connect()


@app.after_request
def after_request(response):
    db.close()
    return response


if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=80)
