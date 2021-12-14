from src.controller.ocr_cupom_controller import OcrCupomCommandController


def lambda_handler(event, context):
    return {
        "headers": {"Content-Type": "application/json"},
        "statusCode": 200,
        "body": {
            "testes": "ok"
        }
    }
    #return OcrCupomCommandController(event).invoke()