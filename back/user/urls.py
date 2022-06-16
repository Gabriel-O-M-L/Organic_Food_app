from django.urls import path

from user.views import UserView

urlpatterns = [
    path('login/', UserView.as_view({
        'post': 'sign_in'
    })),
    path('create/', UserView.as_view({
        'post': 'create'
    })),
    path('forgot/', UserView.as_view({
        'post': 'change_password'
    })),
    path('getuser/', UserView.as_view({
        'post': 'getUser'
    })),
    path('personal/', UserView.as_view({
        'post': 'add_data'
    })),
    path('delete/', UserView.as_view({
        'delete': 'delete'
    }))
]