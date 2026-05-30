This folder contains helper scripts for the repo.

extract_and_build.sh
- Purpose: Extract `longwoodgeek-games-site-starter.zip` into the `site/` folder and build the site if `mkdocs.yml` is present.
- Usage (from repo root):

```bash
bash scripts/extract_and_build.sh
```

- Notes:
  - The script will detect a prebuilt static site (looks for `site/index.html`) and skip building.
  - If `mkdocs.yml` exists and `mkdocs` is installed, the script will run `mkdocs build`.
  - Make the script executable if you prefer: `chmod +x scripts/extract_and_build.sh`.
