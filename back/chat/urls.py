from django.urls import path
from chat.views import ChatViews,ChatbotViews
from django.conf.urls import url

urlpatterns = [
    path('sendBot/', ChatbotViews.as_view({
        'post': 'sendText'
    })),
    path('create/', ChatViews.as_view({
        'post': 'create'
    })),
    path('receive/', ChatViews.as_view({
        'get': 'receive'
    })),
    path('send/', ChatViews.as_view({
        'post': 'send'
    })),
]
