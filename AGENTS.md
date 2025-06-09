# Development Guidelines

- When running binaries or tests, enable performance counters if available.
- Collect percentile distributions for performance data rather than just averages.
- Debug any issues encountered during compilation or runtime and document the resolution steps.
- If code fails to run, fix compilation errors, resolve linking issues, or debug runtime crashes. Document what prevented execution.
- Profile code to find hotspots and optimize where possible.
- Consider caching PM endpoint capabilities and optimizing message marshaling. Remove unnecessary memory barriers.
- Refactor touched files toward C23 and x86_64v1 with SIMD optimizations and SMP awareness.
- Format code using modern conventions and ensure all code is commented.
