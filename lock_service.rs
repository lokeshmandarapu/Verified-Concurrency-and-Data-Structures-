#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct LockService {
    owner: Option<u64>,
}

impl LockService {
    pub fn new() -> Self { Self { owner: None } }

    pub fn acquire(&mut self, client: u64) -> bool {
        if self.owner.is_none() {
            self.owner = Some(client);
            true
        } else { false }
    }

    pub fn release(&mut self, client: u64) -> bool {
        if self.owner == Some(client) {
            self.owner = None;
            true
        } else { false }
    }

    pub fn owner(&self) -> Option<u64> { self.owner }

    pub fn invariant_safety(&self) -> bool { true }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn safety_single_owner() {
        let mut ls = LockService::new();
        assert!(ls.acquire(1));
        assert!(!ls.acquire(2));
        assert_eq!(ls.owner(), Some(1));
        assert!(ls.invariant_safety());
    }
}
