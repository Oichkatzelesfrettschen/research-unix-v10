# IP Fragment Reassembly

This note outlines the main phases of `ip_reass()` and how the timeout
handler cleans up unfinished fragment queues.

## ip_reass() flow
1. **Locate or create reassembly queue:** The function searches the
global `ipq` list for an entry matching the fragment's ID, source,
destination, and protocol. If the packet is not a fragment, any existing
queue for that ID is discarded and the packet is returned unchanged
(lines 135–153 of `ip_input.c`). If no queue exists, a new one is
allocated and inserted at the head of `ipq` (lines 155–178).
2. **Insert the fragment:** The code finds the proper position in the
fragment list, trimming overlaps with previous or subsequent fragments
(lines 185–224). The new fragment is then linked into the chain and the
routine checks if the sequence of offsets is contiguous (lines 226–246).
3. **Assemble final packet:** When all fragments have arrived, the
routine concatenates the data blocks, updates the header, removes the
queue header, and returns a complete datagram (lines 248–270).

## Timeout handling
The `ip_slowtimo()` routine decrements a TTL counter in each reassembly
queue. When the counter reaches zero, the entire queue is freed
(lines 308–319 of `ip_input.c`). This function is periodically rescheduled
using `timeout()` so stale fragment queues are cleaned up automatically.
