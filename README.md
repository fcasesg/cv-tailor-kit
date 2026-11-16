# CV Tailor Kit

Paste a job description into Claude Code, get a tailored one-page CV and cover letter as PDFs.

## How it works

- `master/cv-content.yaml` is your full CV (the source of truth).
- `/tailor` reads a job description, picks and reorders your best bullets for that role, writes a cover letter, and compiles both to PDF in `applications/<company-role>/`.
- It never invents experience. It only selects from your master CV.

## Setup (once)

1. Install [Claude Code](https://claude.com/claude-code).
2. Install Typst (the PDF compiler):
   ```bash
   brew install typst
   ```
3. Get this folder:
   ```bash
   git clone <repo-url>
   cd cv-tailor-kit
   ```
4. Replace the example content in `master/cv-content.yaml` with your own CV.
5. Check it renders:
   ```bash
   typst compile templates/cv-pretty.typ master/CV.pdf --root .
   open master/CV.pdf
   ```

## Use

```bash
cd cv-tailor-kit
claude
```
Then type `/tailor` and paste the job description.

## Tips

- Put more bullets in the master than fit on a page. Tailoring works by choosing.
- Always read the output before sending. Edit the YAML and recompile if needed.
- Fonts: uses Helvetica Neue (Mac). On Windows/Linux it falls back to Arial.
- Your `applications/` folder and PDFs are git-ignored, so they never get pushed.
