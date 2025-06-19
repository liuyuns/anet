## [Iteration Info]

### - batch=64
### - subdivisions=16
 
- number_of_images_per_iteration = batch
- one_iteration is splited into loops of subdivision
  For each loop, it handles batch/subdivision amount of images 
  if GPU memory error, increase subdivisions, so one loop handles less images 
- 1 epoch = [number_of_assets / batch] iterations
  e.g. batch = 64, 640 images, 1 epoch = 10 iterations
 

## [Net resolution]
### - width=416
### - height=416

- the resolution that images will be scaled to

## [Image channels]
### - channels=3
- RGB

## [Convolutional layer weight update]
### - momentum=0.9

- bias_update *= momentum;
- weights_updates *= momentum

### - decay=0.0005
- weights_updates += weights * -decay * batch


The code: 

<code>

void update_convolutional_layer(convolutional_layer l, int batch, float learning_rate, float momentum, float decay){
    int size = l.size*l.size*l.c*l.n;

    axpy_cpu(l.n, learning_rate/batch, l.bias_updates, 1, l.biases, 1);

    scal_cpu(l.n, momentum, l.bias_updates, 1);

    if(l.scales){
        axpy_cpu(l.n, learning_rate/batch, l.scale_updates, 1, l.scales, 1);
        scal_cpu(l.n, momentum, l.scale_updates, 1);
    }

    axpy_cpu(size, -decay*batch, l.weights, 1, l.weight_updates, 1);
    axpy_cpu(size, learning_rate/batch, l.weight_updates, 1, l.weights, 1);
    scal_cpu(size, momentum, l.weight_updates, 1);

}

</code>

## [Image augumentation]
### - angle=0
- Random rotate the image, not used for object detection by reading the code.

### - saturation = 1.5
### - exposure = 1.5
### - hue = .1

- Random change colors during training, for data augumentation, in terms of HSV
https://en.wikipedia.org/wiki/HSL_and_HSV


## [Learning rate]
### - learning_rate=0.001
### - burn_in=1000

- before reaching burn_in real batches, learning_rate is got using below formula:    
 <code>
 learning_rate = net.learning_rate * pow((float)batch_num / net.burn_in, net.power)
 </code>

- after burn_in batches, learning_rate will be got based on policy below.

## [Max iterations for train]
### - max_batches = 15000
- the max iterations that the train will run if not manually stopped.


## [How learning rate is updated]
### - policy=steps
### - steps=400,450
### - scales=.1,.1


<b>Explanation of Policies</b>:

- CONSTANT
    not changing as it says

- STEP
    net.learning_rate * pow(net.scale, batch_num/net.step);

- STEPS
    learning_rate *= scales[i] if steps[i] > batch_num

- EXP
    net.learning_rate * pow(net.gamma, batch_num)
    default gamma is 1

- POLY
    net.learning_rate * pow(1 - (float)batch_num / net.max_batches, net.power)
    default power is 4

- RANDOM
    net.learning_rate * pow(rand_uniform(0,1), net.power)

- SIG
    net.learning_rate * (1./(1.+exp(net.gamma*(batch_num - net.step))))

