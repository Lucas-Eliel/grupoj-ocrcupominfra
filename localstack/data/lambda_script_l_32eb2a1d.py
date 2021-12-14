from controller import OcrCupomCommandController


def lambda_handler(event, context):
    return OcrCupomCommandController(event).invoke()
