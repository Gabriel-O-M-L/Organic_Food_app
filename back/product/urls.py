from django.urls import path

from product.views import ProductView

urlpatterns = [
    path('create/', ProductView.as_view({
        'post': 'create'
    })),
    path('near/', ProductView.as_view({
        'post': 'close_items'
    })),
    path('show/', ProductView.as_view({
        'post': 'showProducts'
    })),
]