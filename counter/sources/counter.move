module counter::counter; 

use sui::event;

const E_NOT_OWNER: u64 = 0;

public struct Counter has key {
    id: UID,
    owner: address,
    value: u64,
    created_at: u64,
}

public struct CounterCreatedEvent has copy, drop {
    owner: address,
    timestamp: u64,
}

public struct CounterIncrementedEvent has copy, drop {
    owner: address,
    new_value: u64,
}

public fun create_counter(ctx: &mut TxContext) {
    let sender = tx_context::sender(ctx);
    let timestamp = tx_context::epoch(ctx);

    let counter = Counter {
        id: object::new(ctx),
        owner: sender,
        value: 0,
        created_at: timestamp,
    };

    event::emit(CounterCreatedEvent { owner: sender, timestamp });
    transfer::transfer(counter, sender);
}

public fun increment(counter: &mut Counter, ctx: &mut TxContext) {
    let sender = tx_context::sender(ctx);
    if (sender != counter.owner) {
        abort E_NOT_OWNER
    };

    counter.value = counter.value + 1;
    event::emit(CounterIncrementedEvent { owner: sender, new_value: counter.value });
}

public fun get_value(counter: &Counter): u64 {
    counter.value
}

public fun get_owner(counter: &Counter): address {
    counter.owner
}

public fun get_creation_time(counter: &Counter): u64 {
    counter.created_at
}

