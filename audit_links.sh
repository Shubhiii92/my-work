#!/usr/bin/env bash
set -euo pipefail

BASE_URL="https://shubhiii92.github.io/e-cycle-hub"
ASSIGN_DIR="assignments"

# List of files (from repository)
files=(
  "EWM_Assignment_0.pdf"
  "EWM_Assignment_10.pdf"
  "EWM_Assignment_1_partB.docx"
  "EWM_Assignment_1_partB.pdf"
  "EWM_Assignment_1_partC.xlsx"
  "EWM_Assignment_2.pdf"
  "EWM_Assignment_3.pdf"
  "EWM_Assignment_4.pdf"
  "EWM_Assignment_5.docx"
  "EWM_Assignment_5.pdf"
  "EWM_Assignment_6_partA.docx"
  "EWM_Assignment_6_partA.pdf"
  "EWM_Assignment_6_partB.pdf"
  "EWM_Assignment_7_partA.mp4"
  "EWM_Assignment_7_partB.jpeg"
  "EWM_Assignment_9_partA.pdf"
  "EWM_Assignment_9_partA.pptx"
  "EWM_Assignment_9_partB.pdf"
  "IEEE_Agent_Capability_Scanner_Paper_FINAL.pdf"
)

printf "\n--- Local file existence check ---\n"
for f in "${files[@]}"; do
  if [[ -f "$ASSIGN_DIR/$f" ]]; then
    echo "✔ $f exists locally"
  else
    echo "✖ $f MISSING locally"
  fi
done

printf "\n--- Live URL verification (HTTP status) ---\n"
failed=0
for f in "${files[@]}"; do
  url="$BASE_URL/$ASSIGN_DIR/$f"
  status=$(curl -s -o /dev/null -w "%{http_code}" "$url" || echo "000")
  if [[ "$status" == "200" ]]; then
    echo "✔ $url -> 200"
  else
    echo "✖ $url -> $status"
    ((failed++))
  fi
done

# External applications
external=(
  "https://himachalpradesh-sdg-tracker.lovable.app/"
  "https://rj42-coder.github.io/e-waste-epr-calculator/"
  "https://shard-c6.github.io/EWaste_GDP_Dashboard/"
  "https://jazzy-lily-3ec69a.netlify.app/"
)

printf "\n--- External application URLs ---\n"
for url in "${external[@]}"; do
  status=$(curl -s -o /dev/null -w "%{http_code}" "$url" || echo "000")
  if [[ "$status" == "200" ]]; then
    echo "✔ $url -> 200"
  else
    echo "✖ $url -> $status"
    ((failed++))
  fi
done

printf "\nAudit complete. Failed checks: $failed\n"

