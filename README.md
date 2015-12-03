# grammar-csv-export
For exporting questions from Firebase to CSV

There is a list of skipped objects in `initialize` (`@missing_fields`), which had bad data. These may be outdated/incomplete. If you want to skip a different one, just add it to the array.

Otherwise, pulling the most updated JSON from firebase then running the file `$ ruby parser.rb` should give you a CSV with most information.
