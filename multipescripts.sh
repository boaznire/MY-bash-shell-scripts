#!/bin/bash

bash /home/boaze/statistics.sh > /home/boaze/statistics.txt
awk '{ sub(/^[ \t]+/, ""); print }' /home/boaze/statistics.txt
