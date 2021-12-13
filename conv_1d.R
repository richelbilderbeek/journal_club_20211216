
library(keras)
model <- keras_model_sequential()


model %>% 
  
  # Adds a densely-connected layer with 64 units to the model:
  layer_dense(units = 64, activation = 'relu') %>%
  
  # Add another:
  layer_dense(units = 64, activation = 'relu') %>%
  
  # Add a softmax layer with 10 output units:
  layer_dense(units = 10, activation = 'softmax')
