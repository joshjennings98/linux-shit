#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Launch bars
polybar screen1 & polybar screen2
