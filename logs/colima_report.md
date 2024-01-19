# Topic: Colima_report Thursday, January 18th, 2024

## What do you want to remember about it?
- The defaults for colima (2 cores of CPU, 2GB of memory, 60gb disk) are not sufficient for test runs. Tests will begin to timeout one by one
   Fix: `colima start --cpu 4 --memory 8`
   Why? M1s have 8 cores, and 32gb RAM. Allocating half of that to colima tasks will greatly increase throughput
   Note: Disk's default of 60gb is fine for now it seems

## What are some outstanding questions?

## What relevant projects

tags: #example-topic-idea
