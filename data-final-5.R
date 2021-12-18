#각 패키지 장착
#library(rpart) #결정
#library(randomForest) #포레스트
#library(e1071) #SVM
#library(caret) #혼돈행렬
#library(class) #K-NN

#데이터를 변수에 저장
ucla = read.csv('http://stats.idre.ucla.edu/stat/data/binary.csv')

#(준비과정)Label 인 admin을 factor로 변환 회귀가 아닌 분류로 실행하기 위해
ucla$admit = factor(ucla$admit)

#sample 함수를 통해 6:4로 분류
idx = sample(1:nrow(ucla),nrow(ucla)*0.6)
train = ucla[idx,]
test = ucla[-idx,]
#개수확인
nrow(train)
nrow(test)

#3. 학습 데이터 예측 모델 만들기

#결정트리 모델링
r = rpart(admit~., data = train)
#랜덤포레스트 tree 50개 모델
f50 = randomForest(admit~., data = train, ntree = 50)
#랜덤포레스트 tree 1000개
f1000 = randomForest(admit~., data = train, ntree = 1000)
#svm Kernel = 'polynomial'
sP = svm(admit~., data = train, kernel = 'polynomial')
#svm Kernel = 'radial'
sR = svm(admit~., data = train, kernel = 'radial')
#knn
k_pred = knn(train[,1:4], test, train$admit, k = 5)


#결정트리 예측
r_pred = predict(r, test, type = 'class')
#혼돈행렬
table(r_pred, test$admit)
confusionMatrix(r_pred, test$admit)
#50개 예측
f50_pred = predict(f50, test, type = 'class')
#혼돈행렬
table(f50_pred, test$admit)
confusionMatrix(f50_pred, test$admit)
#1000개 예측
f1000_pred = predict(f1000, test, type = 'class')
#혼돈행렬
table(f1000_pred, test$admit)
confusionMatrix(f1000_pred, test$admit)
#svm polynomial 모델 예측
sP_pred = predict(sP, test, type = 'class')
#혼돈행렬
table(sP_pred, test$admit)
confusionMatrix(sP_pred, test$admit)
#svm Radial 모델 예측
sR_pred = predict(sR, test, type = 'class')
#혼돈행렬
table(sR_pred, test$admit)
confusionMatrix(sR_pred, test$admit)
#k-nn 모델 예측
#위에서 정의한 k_pred
#혼돈행렬
table(k_pred, test$admit)
confusionMatrix(k_pred, test$admit)