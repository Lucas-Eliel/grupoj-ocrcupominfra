from src.controller.ocr_cupom_controller import OcrCupomCommandController


def lambda_handler(event, context):
    return OcrCupomCommandController().invoke(event)