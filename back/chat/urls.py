from django.urls import path
from chat.views import ChatViews,ChatbotViews

urlpatterns = [
    path('sendBot/', ChatbotViews.as_view({
        'post': 'sendText'
    })),
    path('create/', ChatViews.as_view({
        'post': 'create'
    })),
    path('receive/', ChatViews.as_view({
        'post': 'receive'
    })),
    path('getlist/', ChatViews.as_view({
        'post': 'getchatlist'
    })),
    path('getchat/', ChatViews.as_view({
        'post': 'getchat'
    })),
    path('send/', ChatViews.as_view({
        'post': 'send'
    })),
]
