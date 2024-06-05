from django.urls import path
from .views import VectorOperationView, ExpressionOperationView

urlpatterns = [
    path('vector/operation/', VectorOperationView.as_view(), name="vector_operation"),
    path('expression/operation/', ExpressionOperationView.as_view(), name="expression_operation"),
]