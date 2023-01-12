from flask import Flask, request
from models import Product

app = Flask(__name__)


@app.route("/")
def index():
    return {"message": "Api is running"}


@app.route("/api")
def heartbeat():
    return {"message": "Api is running"}


@app.route("/api/products")
def get_products():
    search_term = request.args.get("search_term")
    category = request.args.get("category")

    q = Product.select()
    if search_term:
        q = q.where(Product.brand.like(f"%{search_term}%"))
    if category:
        q = q.where(Product.category == category)

    q = q.limit(10)

    return [product.to_dict() for product in q]


@app.route("/api/products/<int:product_id>")
def get_product(product_id):
    q = Product.select().where(Product.id == product_id)
    if q.exists():
        return q[0].to_dict()
    else:
        return {"message": "not found"}, 404


if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=80)
