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

## Make it better: add your material

The more real evidence Claude has, the better the tailoring. There are two folders for this, and both stay private (git-ignored):

| Folder | What goes in it | How it's used |
|---|---|---|
| `sources/` | LinkedIn PDF, old CVs, performance reviews, project write-ups | Raw material to build and expand your master CV |
| `stories/` | One file per achievement, in STAR format (Situation, Task, Actions, Results) | `/tailor` pulls concrete evidence from these for the cover letter |

**Getting your LinkedIn PDF:** go to your profile, click "Resources" (or "More"), then "Save to PDF".

**Writing stories:** pick 5-10 achievements you're proud of. For each, write what happened, what *you* did, and the result with numbers. Not sure where to start? Ask Claude: *"Interview me about my time at [company] and turn it into a story in stories/."* These also make great prep for behavioural interviews.

**Keeping the master up to date:** after you add new sources or stories, ask Claude: *"Check sources/ and stories/ for anything missing from master/cv-content.yaml and suggest additions."* Review the suggestions before accepting them.

## Tips

- Put more bullets in the master than fit on a page. Tailoring works by choosing.
- Always read the output before sending. Edit the YAML and recompile if needed.
- Fonts: uses Helvetica Neue (Mac). On Windows/Linux it falls back to Arial.
- Your `applications/` folder and PDFs are git-ignored, so they never get pushed.
