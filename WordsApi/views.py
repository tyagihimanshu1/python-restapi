from django.shortcuts import render
import json
from rest_framework.response import Response
from rest_framework.views import APIView
from WordsApi.utilities import Utilities
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework import status

class ReplaceWords(APIView):
    authentication_classes = [BasicAuthentication]
    permission_classes = [IsAuthenticated,]
    
    def post(self,request):
        try:
            if 'inputStr' in request.data:
                copyRight = "\N{COPYRIGHT SIGN}"
                keyWords = {'Google':'Google'+copyRight,'Microsoft':'Microsoft'+copyRight,
                            'Amazon':'Amazon'+copyRight,'Oracle':'Oracle'+copyRight,'Deloitte':'Deloitte'+copyRight}
                utils =  Utilities()
                outputStr = utils.replace(request.data['inputStr'],keyWords)
                if outputStr:
                    return Response({'outputStr':outputStr}, status.HTTP_200_OK)
                else:
                    return Response({'outputStr':'OUTPUT NOT_FOUND'}, status.HTTP_404_NOT_FOUND)
            else:
                return Response({'outputStr':'BAD_REQUEST'},status.HTTP_400_BAD_REQUEST)
        except Exception as err:
            return Response(err,status.HTTP_500_INTERNAL_SERVER_ERROR)
