from django.urls import path

from user.views import UserView

urlpatterns = [
    path('authentication/', UserView.as_view({
        'post': 'sign_in'
    })),
    path('enter/', UserView.as_view({
        'post': 'create'
    }))
]
