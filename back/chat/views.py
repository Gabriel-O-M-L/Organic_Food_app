import json
import os
from rest_framework.response import Response
from rest_framework import viewsets,status
from chat.models import chat
import google.cloud.dialogflow_v2 as dialogflow
from google.protobuf import struct_pb2 as pb
import jwt
from user.models import User

from chat.serializer import chatSerial
from chat.models import chat
from django.db.models import Case, Value, When, Q

class ChatbotViews(viewsets.ViewSet):

    GOOGLE_AUTHENTICATION_FILE_NAME = "dialogflow_variables.json"
    current_directory = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(current_directory, GOOGLE_AUTHENTICATION_FILE_NAME)
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = path
    GOOGLE_PROJECT_ID = 'organicapp'

    def sendText(self, request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',algorithms='HS256')

        session_id = str(decoded_jwt['user_id'])
        context_short_name = "does_not_matter"
        context_name = "projects/" + ChatbotViews.GOOGLE_PROJECT_ID + "/agent/sessions/" + session_id + "/contexts/" + \
                       context_short_name.lower()


        parameters = pb.Struct()


        context_1 = dialogflow.Context(
            name=context_name,
            lifespan_count=2,
            parameters=parameters
        )
        query_params_1 = {"contexts": [context_1]}

        language_code = 'pt-br'

        response = ChatbotViews.detect_intent_with_parameters(
            project_id=ChatbotViews.GOOGLE_PROJECT_ID,
            session_id=session_id,
            query_params=query_params_1,
            language_code=language_code,
            user_input=request.data.get("user_message", None)
        )
        returns = response.query_result.fulfillment_text
        return Response({"fulfilment_text": returns}, status=200,content_type="application/json")

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

class ChatViews(viewsets.ViewSet):

    def create(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')

        user_receive = User.objects.get(id=request.data.get('S_id', None))
        user_sender = User.objects.get(id=decoded_jwt['user_id'])

        lista = []
        text = request.data.get('text', None) + " 1"
        lista.append(text)

        chat = chatSerial(data={
            'U_id_sender': user_sender.pk,
            'U_id_receiver': user_receive.pk,
            'text': lista,
        })

        if chat.is_valid(raise_exception=True):

            chat.save()
            return Response(chat.data, status=200, content_type="application/json")
        else:
            return Response(chat.errors, status=400)

    def receive(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        userChat = chat.objects.get((Q(U_id_sender_id=user.id)|Q(U_id_sender_id=request.data.get('S_id', None)) & (Q(U_id_receiver__id=request.data.get('S_id', None))|Q(U_id_sender_id=user.id))))

        return Response({
            "text": userChat.text
        },status=200,content_type="application/json")

    def send(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        if (user.id == request.data.get('U_id_sender', None)):
            userChat = chat.objects.filter(U_id_sender=user.id)
            userChat = userChat.get(U_id_receiver=request.data.get('U_id_receiver', None))
            if(userChat.text is None):
                userChat.text = []
            text = request.data.get('text', None) + " 1"
            userChat.text.append(text)


        else:
            userChat = chat.objects.filter(U_id_receiver__id=user.id)
            chats = chat.objects.filter(U_id_sender=request.data.get('U_id_sender', None)).first()
            userChat = userChat.get(U_id_sender=request.data.get('U_id_sender', None))
            if (userChat.text is None):
                userChat.text = []
            text = request.data.get('text', None) + " 0"
            userChat.text.append(text)

        userChat.save()
        return Response(status=200)

    def getchatlist(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])

        chatlist = chat.objects.filter(Q(U_id_sender_id=user.id) | Q(U_id_receiver__id=user.id))

        idList = []
        for i in chatlist:
            idList.append(i.chatId)

        idList = json.dumps(idList)
        return Response({
            "idlist": idList
        },status=200,content_type="application/json")

    def getchat(self,request):
        userchat = chat.objects.get(chatId=request.data.get('chat_id', None))

        return Response({
                'chatId': userchat.chatId,
                'text': userchat.text,
                'U_id_sender': userchat.U_id_sender.id,
                'U_id_receiver': userchat.U_id_receiver.id,
                'text': userchat.text,
                "name": userchat.U_id_sender.name,
                'secname': userchat.U_id_receiver.name
            }, status=200, content_type="application/json")

