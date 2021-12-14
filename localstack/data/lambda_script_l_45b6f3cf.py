from src.controller.ocr_cupom_controller import OcrCupomCommandController


def lambda_handler(event, context):
    return OcrCupomCommandController(event).invoke()

lambda_handler({
    "resource": "/processamento-ocr-cupom",
    "httpMethod": "POST",
    "body": {
        "cupom": ""
    }
}, {})