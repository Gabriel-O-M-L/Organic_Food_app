from django.urls import path
from cart.views import CartView

urlpatterns = [
    path('show_p/', CartView.as_view({
        'post': 'list'
    })),
    path('create/', CartView.as_view({
        'post': 'create'
    })),
    path('remove/', CartView.as_view({
        'delete': 'remove'
    })),
    path('add/', CartView.as_view({
        'post': 'add'
    })),
    path('show/', CartView.as_view({
        'post': 'show'
    })),
    path('delete/', CartView.as_view({
        'post': 'delete'
    })),
    path('finish/', CartView.as_view({
        'post': 'finish'
    }))
]