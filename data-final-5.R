#�� ��Ű�� ����
#library(rpart) #����
#library(randomForest) #������Ʈ
#library(e1071) #SVM
#library(caret) #ȥ�����
#library(class) #K-NN

#�����͸� ������ ����
ucla = read.csv('http://stats.idre.ucla.edu/stat/data/binary.csv')

#(�غ����)Label �� admin�� factor�� ��ȯ ȸ�Ͱ� �ƴ� �з��� �����ϱ� ����
ucla$admit = factor(ucla$admit)

#sample �Լ��� ���� 6:4�� �з�
idx = sample(1:nrow(ucla),nrow(ucla)*0.6)
train = ucla[idx,]
test = ucla[-idx,]
#����Ȯ��
nrow(train)
nrow(test)

#3. �н� ������ ���� �� �����

#����Ʈ�� �𵨸�
r = rpart(admit~., data = train)
#����������Ʈ tree 50�� ��
f50 = randomForest(admit~., data = train, ntree = 50)
#����������Ʈ tree 1000��
f1000 = randomForest(admit~., data = train, ntree = 1000)
#svm Kernel = 'polynomial'
sP = svm(admit~., data = train, kernel = 'polynomial')
#svm Kernel = 'radial'
sR = svm(admit~., data = train, kernel = 'radial')
#knn
k_pred = knn(train[,1:4], test, train$admit, k = 5)


#����Ʈ�� ����
r_pred = predict(r, test, type = 'class')
#ȥ�����
table(r_pred, test$admit)
confusionMatrix(r_pred, test$admit)
#50�� ����
f50_pred = predict(f50, test, type = 'class')
#ȥ�����
table(f50_pred, test$admit)
confusionMatrix(f50_pred, test$admit)
#1000�� ����
f1000_pred = predict(f1000, test, type = 'class')
#ȥ�����
table(f1000_pred, test$admit)
confusionMatrix(f1000_pred, test$admit)
#svm polynomial �� ����
sP_pred = predict(sP, test, type = 'class')
#ȥ�����
table(sP_pred, test$admit)
confusionMatrix(sP_pred, test$admit)
#svm Radial �� ����
sR_pred = predict(sR, test, type = 'class')
#ȥ�����
table(sR_pred, test$admit)
confusionMatrix(sR_pred, test$admit)
#k-nn �� ����
#������ ������ k_pred
#ȥ�����
table(k_pred, test$admit)
confusionMatrix(k_pred, test$admit)