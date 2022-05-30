import os

from requests import Response
from rest_framework import viewsets
import google.cloud.dialogflow_v2 as dialogflow
from django.http import HttpResponse
from google.protobuf import struct_pb2 as pb
import jwt

class ChatViews(viewsets.ViewSet):

    def sendText(self, request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',algorithms='HS256')
        GOOGLE_AUTHENTICATION_FILE_NAME = "dialogflow_variables.json"
        current_directory = os.path.dirname(os.path.realpath(__file__))
        path = os.path.join(current_directory, GOOGLE_AUTHENTICATION_FILE_NAME)
        os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = path
        GOOGLE_PROJECT_ID = 'organicapp'

        session_id = str(decoded_jwt['user_id'])
        context_short_name = "does_not_matter"
        context_name = "projects/" + GOOGLE_PROJECT_ID + "/agent/sessions/" + session_id + "/contexts/" + \
                       context_short_name.lower()


        parameters = pb.Struct()


        context_1 = dialogflow.Context(
            name=context_name,
            lifespan_count=2,
            parameters=parameters
        )
        query_params_1 = {"contexts": [context_1]}

        language_code = 'en'

        response = ChatViews.detect_intent_with_parameters(
            project_id=GOOGLE_PROJECT_ID,
            session_id=session_id,
            query_params=query_params_1,
            language_code=language_code,
            user_input=request.data.get("user_message", None)
        )
        return HttpResponse(response.query_result.fulfillment_text, status=200)

    def detect_intent_with_parameters(project_id, session_id, query_params, language_code, user_input):

        session_client = dialogflow.SessionsClient()

        session = session_client.session_path(project_id, session_id)
        print('Session path: {}\n'.format(session))

        # text = "this is as test"
        text = user_input

        text_input = dialogflow.types.TextInput(
            text=text, language_code=language_code)

        query_input = dialogflow.types.QueryInput(text=text_input)

        response = session_client.detect_intent(
            session=session, query_input=query_input,

        )

        print('=' * 20)
        print('Query text: {}'.format(response.query_result.query_text))
        print('Detected intent: {} (confidence: {})\n'.format(
            response.query_result.intent.display_name,
            response.query_result.intent_detection_confidence))
        print('Fulfillment text: {}\n'.format(
            response.query_result.fulfillment_text))

        return response

