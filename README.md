## Sui Bootcamp Homework Assignment


### Package deployment ID
0xb86b8195b0ac8d4975892b2c10f923ed06af9077f4ac2a1ba5c4b27114f430fa

```
![1.16](readme_assets/l16.png)
![1.17](readme_assets/l17.png)

```
### Instructions to build the contract
#### 1

```
sui move build
sui client publish
![1.1](readme_assets/l1.png)
![1.2](readme_assets/l2.png)
![1.3](readme_assets/l3.png)
![1.4](readme_assets/l4.png)

```
#### 2 

```

![1.5](readme_assets/l5.png)

```

#### 3 create counter

```
sui client ptb --gas-budget 20000000   --move-call 0xb86b8195b0ac8d4975892b2c10f923ed06af9077f4ac2a1ba5c4b27114f430fa::counter::create_counter
![1.6](readme_assets/l6.png)
![1.7](readme_assets/l7.png)
![1.8](readme_assets/l8.png)

```
#### 4 increment counter: new-value = 1 so the counter incremented with success from 0 to 1

```
sui client ptb --gas-budget 2000000 \
>   --move-call 0xb86b8195b0ac8d4975892b2c10f923ed06af9077f4ac2a1ba5c4b27114f430fa::counter::increment \
>   "@0x55f55093ff10cae95d97492ecb4049b5cac7deb1d3f1aa892b5f075d5499afe1"

![1.9](readme_assets/l9.png)
![1.10](readme_assets/l10.png)
![1.11](readme_assets/l11.png)

```

#### 5 increment counter multiple times in the same transaction

```
sui client ptb --gas-budget 8000000 \
>   --move-call 0xb86b8195b0ac8d4975892b2c10f923ed06af9077f4ac2a1ba5c4b27114f430fa::counter::increment "@0x55f55093ff10cae95d97492ecb4049b5cac7deb1d3f1aa892b5f075d5499afe1" \
ve-call >   --move-call 0xb86b8195b0ac8d4975892b2c10f923ed06af9077f4ac2a1ba5c4b27114f430fa::counter::increment "@0x55f55093ff10cae95d97492ecb4049b5cac7deb1d3f1aa892b5f075d5499afe1" \
>   --move-call 0xb86b8195b0ac8d4975892b2c10f923ed06af9077f4ac2a1ba5c4b27114f430fa::counter::increment "@0x55f55093ff10cae95d97492ecb4049b5cac7deb1d3f1aa892b5f075d5499afe1"


![1.12](readme_assets/l12.png)
![1.13](readme_assets/l13.png)
![1.14](readme_assets/l14.png)
![1.15](readme_assets/l15.png)

```

### Brief explanation of code 
#### As seen above the implementation allows each user to create their own counter, increment it if they are the owner, and track its creation and increments using events. 
The main Counter object, marked with has key, represents each counter with a unique identifier (id), an owner address (owner), a current value (value), and a creation timestamp (created_at). 
When a counter is created, a CounterCreatedEvent is emitted, storing the owner and creation epoch, and when the counter is incremented, a CounterIncrementedEvent is emitted with the owner and new value. The create_counter function initializes a counter with value zero, sets the sender as the owner, records the creation epoch, emits the creation event, and transfers the object to the sender. 
The increment function increases the counter by one but only allows the owner to do so, aborting with E_NOT_OWNER otherwise, and emits an increment event. The module also provides helper functions: get_value returns the current counter value, get_owner returns the owner, and get_creation_time returns the creation epoch.