#!/bin/sh

echo "Perform database restore"
sh sql/scripts/setup.sh

echo "Import all test sql"
sh sql/scripts/tests.sh