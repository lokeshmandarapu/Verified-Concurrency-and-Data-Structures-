// Verus proofs and specifications for the lock service.
// Requires Verus toolchain. https://github.com/verus-lang/verus

#[allow(unused_imports)]
use vstd::prelude::*;
#[allow(unused_imports)]
use vstd::set::*;

verus! {

// Extract an abstract set of holders from concrete state.
pub open spec fn holders(owner: Option<u64>) -> Set<u64> {
    match owner {
        Option::Some(id) => set![id],
        Option::None => Set::empty(),
    }
}

// Safety: at most one holder exists.
pub proof fn lemma_mutual_exclusion(owner: Option<u64>)
    ensures holders(owner).len() <= 1
{}

// Pure transition specs for reasoning about acquire and release.
pub open spec fn acquire_next(owner: Option<u64>, client: u64) -> Option<u64> {
    match owner {
        Option::None => Option::Some(client),
        Option::Some(_) => owner,
    }
}

pub open spec fn release_next(owner: Option<u64>, client: u64) -> Option<u64> {
    match owner {
        Option::Some(id) => if id == client { Option::None } else { owner },
        Option::None => owner,
    }
}

// Acquiring when free installs the client as the unique holder.
pub proof fn lemma_acquire_when_free(client: u64)
    ensures holders(acquire_next(Option::None, client)) == set![client]
    ensures holders(acquire_next(Option::None, client)).len() == 1
{}

// Releasing by the owner frees the lock.
pub proof fn lemma_release_by_owner(client: u64)
    ensures release_next(Option::Some(client), client) == Option::None
    ensures holders(release_next(Option::Some(client), client)).len() == 0
{}

// Acquire and release preserve safety.
pub proof fn lemma_preserves_safety(owner: Option<u64>, client: u64)
    ensures holders(acquire_next(owner, client)).len() <= 1,
            holders(release_next(owner, client)).len() <= 1
{}

} // end verus!
