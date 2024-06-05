from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .calculations import Vector, Expression
import json


class VectorOperationView(APIView):
    def post(self, request, format=None):
        try:
            
            data = json.loads(request.body)
            operation = data.get('operation')
            vectors = data.get('vectors')

            if not vectors or not all(len(vec) == 3 for vec in vectors):
                return Response("Each Vector Must Have Three Components: (x, y, z).")

            if operation == 'dot_product':
                v1 = Vector(*vectors[0])
                v2 = Vector(*vectors[1])
                result, steps = v1.find_dot(v2)

            elif operation == 'cross_product':
                v1 = Vector(*vectors[0])
                v2 = Vector(*vectors[1])
                result, steps = v1.cross_prod(v2)

            elif operation == 'magnitude':
                v = Vector(*vectors[0])
                result, steps = v.magnitude()

            elif operation == 'unit_vector':
                v = Vector(*vectors[0])
                result, steps = v.unit_vector()
            else:
                return Response({"error": 'Invalid Operation'}, status=status.HTTP_400_BAD_REQUEST)

            return Response({
            'result': str(result),
            'steps': steps,
            }, status= status.HTTP_200_OK)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

    
class ExpressionOperationView(APIView):
    def post(self, request, format=None):
        try:
            data = json.loads(request.body)
            operation = data.get('operation')
            expression = data.get('expression')
            variable = data.get('variable')

            expr = Expression(expression)
            if operation == 'derivative':
                result, steps = expr.take_deriv(variable)

            elif operation == 'integral':
                limits = data.get('limits')
                result, steps = expr.take_integral(variable, limits)
            else:
                return Response({"error": "Invalid Operation"}, status=status.HTTP_400_BAD_REQUEST)

            return Response({
                "result": result,
                "steps": steps
            }, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)