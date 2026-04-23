# CX NEXUS — password-protected landing preview

Two versions of the CX NEXUS landing redesign, deployed to GitHub Pages behind a StatiCrypt password gate.

- `index.html` — default preview (Bebas Neue + Heebo)
- `cx-nexus-landing-v2.html` — alternative typography (Archivo Black + Inter)

The repo root contains **encrypted** HTML ready to serve. Source HTML lives under `src/` and is what you edit + re-encrypt.

## Current password

A placeholder password is baked in: **`cxnexus-preview-2026`**.

Before sharing the URL with anyone outside your circle, **change it** (see below).

## Deploy to GitHub Pages

1. Create an empty private repo on GitHub named `cx-nexus`.
2. From this folder, push:
   ```bash
   git remote add origin git@github.com:<your-username>/cx-nexus.git
   git branch -M main
   git push -u origin main
   ```
3. In GitHub → **Settings → Pages**:
   - Source: *Deploy from a branch*
   - Branch: `main` / folder: `/ (root)`
4. Wait ~1 minute. Your site is live at:
   `https://<your-username>.github.io/cx-nexus/`

The preview URL will show a password prompt. Enter the password to view the pages.

## Change the password

Node.js is required.

```bash
npm install                                # installs staticrypt
STATICRYPT_PASSWORD='your-new-password' npm run encrypt
git add -A
git commit -m "Rotate preview password"
git push
```

Pages will redeploy automatically. The new password is the one reviewers need.

## Edit the pages

1. Edit HTML in `src/` (same structure as the originals).
2. Re-encrypt:
   ```bash
   STATICRYPT_PASSWORD='your-password' npm run encrypt
   ```
3. Commit & push.

## Notes

- StatiCrypt uses AES-256 to encrypt the page content client-side. Without the password, the browser only shows the gate — the page markup is not recoverable.
- GitHub Pages still serves the encrypted HTML publicly; protection is entirely on the client. This is "good enough" for share-with-invited-people, not for regulated/sensitive material.
- `.staticrypt.json` stores the salt (not the password). Committing it is fine.
