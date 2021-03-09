# ServiceDataScience_Flutter
*개요 : 국민건강영양조사 데이터에 따른 회귀 머신러닝 모델을 개발하여, 각 개인의 식습관 분석을 통해 미래 몸무게 및 BMI를 예측하는 서비스를 제공하는 앱이다. 추가적으로 다이어트를 위한 다양한 솔루션 제공까지 기획해 볼 생각이다.

국민건강영양조사 데이터는 다음과 같다.

![image](https://user-images.githubusercontent.com/56333934/110413446-3162a280-80d1-11eb-813c-5c971452fdd3.png)

2016년의 데이터를 사용하였으며, 추후 년도 수를 늘려가며 데이터의 양을 늘릴 계획이다.
총 데이터는 8150개(명)이고 BMI지수를 y(종속변수), 주당 섭취하는 음식들을 x(독립변수)로 하여 회귀분석을 진행하고자 한다.

각 독립변수들은 연관성, 다중공선성 문제를 해결하기 위해 불필요한 변수는 제거하고 남은 변수들로 XGboost, RandomForest 기법 등을 사용하여 가장 정확도가 높은 모델을 사용하고자 한다.
