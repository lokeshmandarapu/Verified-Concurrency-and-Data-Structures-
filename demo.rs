use verus_lock_service::lock_service::LockService;

fn main() {
    let mut ls = LockService::new();
    println!("Acquire(1): {}", ls.acquire(1));
    println!("Acquire(2): {}", ls.acquire(2));
    println!("Owner now: {:?}", ls.owner());
    println!("Release(1): {}", ls.release(1));
    println!("Owner now: {:?}", ls.owner());
}
