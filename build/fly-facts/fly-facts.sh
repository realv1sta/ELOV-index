#!/usr/bin/env bash

facts=(
    "Air traffic control is mostly just highly stressed adults playing a very high-stakes game of 'Frogger' with multi-ton metal tubes."
    "The 'Black Box' flight recorder is actually bright orange. Aviation engineers apparently love a good mystery joke."
    "An airplane cabin is pressurized to about 6,000–8,000 feet, which is why your $12 airport bag of potato chips puffs up like a balloon before takeoff."
    "Pilot 'checklists' exist because even seasoned captains can forget things, like lowering the landing gear. Turns out, 'I got this' is a famous last thought."
    "Birds are basically biological cruise missiles with zero regard for FAA regulations. Airplane windshields are tested by shooting dead chickens out of a cannon to prove it."
    "Turbulence is basically just hitting invisible speed bumps in the sky caused by air getting bumpy. The plane isn't falling out of the sky; it's just driving over a very large pothole."
    "The overhead bins on commercial airliners are strictly governed by an ancient tribal ritual known as 'Tetris for People Who Brought Too Much Luggage.'"
    "Oxygen masks drop down automatically because inhaling cool, calming air makes you less likely to panic while staring at a flight attendant doing interpretive dance in the aisle."
    "The pilot's voice over the intercom is intentionally kept calm and soothing, even if the co-pilot just spilled hot coffee in their lap at 35,000 feet."
    "A commercial airliner is basically a flying bus, except nobody wants to make eye contact, and the bathroom smells like regret."
)

num_facts=${#facts[@]}
random_index=$((RANDOM % num_facts))

echo "viation Fact of the Day:"
echo "----------------------------------------"
echo "${facts[$random_index]}"
echo "----------------------------------------"
