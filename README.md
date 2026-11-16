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
4. Build your master CV. Either:
   - **Fast way:** put your LinkedIn PDF and old CVs in `sources/` (see below), open Claude Code in this folder and say:
     *"Read everything in sources/ and rewrite master/cv-content.yaml with my real details. Keep the same structure. Include more bullets than fit on one page. Don't invent anything, and list anything you weren't sure about."*
   - **Manual way:** replace the example content in `master/cv-content.yaml` yourself.
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

## Make it better

Add your own material and Claude will tailor with more real evidence. Both folders are private (git-ignored).

- `sources/`: LinkedIn PDF (Profile > Resources > Save to PDF), old CVs, performance reviews
- `stories/`: one file per achievement: what happened, what *you* did, the result in numbers

Prompts to try:
- *"Interview me about my time at [company] and write it up in stories/."*
- *"Check sources/ and stories/ for anything missing from my master CV."*

## Tips

- Put more bullets in the master than fit on a page. Tailoring works by choosing.
- Always read the output before sending. Edit the YAML and recompile if needed.
- Fonts: uses Helvetica Neue (Mac). On Windows/Linux it falls back to Arial.
- Your `applications/` folder and PDFs are git-ignored, so they never get pushed.
