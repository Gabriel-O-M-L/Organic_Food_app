from django.urls import path
from chat.views import ChatViews

urlpatterns = [
    path('sendBot/', ChatViews.as_view({
        'post': 'sendText'
    })),
]