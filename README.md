
Talk scheduler is implemented as a decreasing first fit algorithm as a solution to the bin packing problem.
Morning and evening session of each track is considered as time buckets and each talk a packet to be packed in the bucket.
As each bucket is filled a new bucket is chosen.

To execute:
ruby talk_scheduler.rb test_input.txt
