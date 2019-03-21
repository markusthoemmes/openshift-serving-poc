# Upstream consumption demo

This is a demo repository that shows how one can consume an upstream project (Knative Serving in this case), while maintaining the ability to follow said upstream closely.

## Use cases

The approach shown here is supposed to fulfill the following use cases:

1. I want to see all the patches we applied to upstream to make it work downstream at a glance.
2. I want the process to update the downstream product to upstream's releases to be quick and non-error-prone.
3. I want to be able to automate the process of updating downstream, if there are no collisions.

### 1. Seeing all patches at a glance

To see all patches at a glance, you can browse the `vendor-patches` directory. It contains all patches that will be applied to the vendored upstream repository after it is checked out. These changes are guaranteed to be the only changes to the upstream repository as the current state is always recreated by deleting the whole directory, checking it out again and applying these patches.

Should an error occur while applying these patches it is immediately clear which patch has caused it and that it's a collision with a patch that **we** created with the upstreams current state.

If a patch is no longer needed it is explictly removed from the repository thus making it visible in the commit history.

### 2. The process to update should be quick and not error prone

Updating the upstream's state is as simple as rerunning `hack/update-deps.sh` given the branch/revision you want to update to. The script will remove the current state and clone the repository from scratch to the revision you told it to. All of the patches needed are applied after the check out is done. If there are conflicts, it will be very clear which patch caused it and it will be very clear that this collision happened while applying the patches that we need.

There's no room for guessing why we see the collision we're seeing.

### 3. Automating the update steps

Step 2 can be automated by running the script nightly and opening a PR should it succeed or an issue should it fail.

## FAQ

### Why not a fork?

A fork gives us the whole history of upstream and mixes it with our very own history. Our own history then is also divided into fixes we needed to apply to the upstream tree and things that we did in our own tree. It's hard to distinguish the two. We don't actually need the whole upstream history in our own history but would much rather only see the things that we did to it and when we bumped to a new version of upstream.