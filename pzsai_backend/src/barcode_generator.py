from PIL import Image, ImageDraw

from main import LINE_WIDTH, LINE_HEIGHT


class BarcodeGenerator:
    def __init__(self, data: str, line_width: int = LINE_WIDTH):
        self.sequence = self.get_sequence(data)
        self.line_width = line_width

        image_width = self.calculate_barcode_px_width(self.sequence)

        self.img = Image.new("RGB", (image_width, LINE_HEIGHT))
        self.draw = ImageDraw.Draw(self.img)
        self.draw.rectangle((0, 0, image_width, LINE_HEIGHT), fill="white")
        self.x = self.line_width * 3

    def calculate_barcode_px_width(self, sequence: str):
        lines_width = sum([
            self.line_width if bit == "0" else self.line_width * 2
            for bit in sequence
        ])
        blanks_width = (len(sequence) - 1) * self.line_width
        stabilization_width = self.line_width * 6

        return lines_width + blanks_width + stabilization_width

    @staticmethod
    def get_sequence(str_number: str) -> str:
        sequence = ""
        sign_table = {
            "start": "110",
            "0": "00110",
            "1": "10001",
            "2": "01001",
            "3": "11000",
            "4": "00101",
            "5": "10100",
            "6": "01100",
            "7": "00011",
            "8": "10010",
            "9": "01010",
            "end": "101"
        }

        sequence += sign_table["start"]
        for digit in str_number:
            sequence += sign_table[digit]
        sequence += sign_table["end"]

        return sequence

    def draw_sequence(self):
        for bit in self.sequence:
            self.draw.rectangle((self.x, 0, self.x + self.line_width, LINE_HEIGHT), fill="black")
            self.x += self.line_width
            if bit == "1":
                self.draw.rectangle((self.x, 0, self.x + self.line_width, LINE_HEIGHT), fill="black")
                self.x += self.line_width
            self.x += self.line_width

    def show_barcode(self):
        self.img.show()

    def save_barcode(self, path):
        self.img.save(path)

# from barcode_generator import BarcodeGenerator
#
# LINE_WIDTH = 6
# LINE_HEIGHT = 200
#
# barcode_generator = BarcodeGenerator("412", 15)
# barcode_generator.draw_sequence()
# barcode_generator.save_barcode("test.png")
