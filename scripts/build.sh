#!/bin/bash
# build.sh
# Script to build the smart contracts and frontend application

set -e

echo "Initializing Anchor workspace..."
anchor init privacy_dex || true

echo "Building smart contracts..."
cd privacy_dex
anchor build

echo "Running tests..."
anchor test

echo "Building frontend application..."
cd frontend
npm install
npm run build
cd ..