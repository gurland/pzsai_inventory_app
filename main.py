from barcode_generator import BarcodeGenerator

LINE_WIDTH = 6
LINE_HEIGHT = 200

barcode_generator = BarcodeGenerator("412", 15)
barcode_generator.draw_sequence()
barcode_generator.save_barcode("test.png")
