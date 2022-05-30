from django.urls import path
from cart.views import CartView

urlpatterns = [
    path('show_p/', CartView.as_view({
        'post': 'list'
    })),
    path('create/', CartView.as_view({
        'post': 'create'
    }))
]