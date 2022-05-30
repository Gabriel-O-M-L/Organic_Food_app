from django.urls import path, include

urlpatterns = [
    path('api/', include('user.urls')),
    path('chat/', include('chat.urls')),
    path('product/', include('product.urls')),
    path('seller/', include('Seller.urls')),
    path('cart/', include('cart.urls'))
]