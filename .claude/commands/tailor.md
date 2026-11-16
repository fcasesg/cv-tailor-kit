# /tailor: Tailor CV and cover letter to a job description

The user has pasted a job description. Create a tailored application folder with a CV and cover letter, compiled as PDFs.

All paths are relative to the project root (the folder containing this `.claude/` directory). Run commands from there.

## Step 1: Extract job metadata

From the job description, extract:
- `company`: company name (short, no legal suffixes)
- `role`: job title (short)
- `folder_name`: lowercase hyphenated slug, e.g. `acme-senior-pm`

## Step 2: Analyse fit

Read `master/cv-content.yaml` and compare against the JD.

Identify:
- Which bullets map directly to the role's requirements
- Which of the candidate's skills match the JD
- JD keywords worth surfacing (tools, methodologies, ways of working)
- Honest gaps. Do not invent experience.

Also check for extra evidence:
- `stories/`: STAR stories about specific achievements. Read the ones relevant to this JD.
- `sources/`: LinkedIn PDF, old CVs, reviews. Skim them if the master CV lacks something the JD asks for.

The master CV stays the source of truth for CV bullets. Stories and sources can add detail to the cover letter. If you find a strong, relevant achievement in stories/sources that is missing from the master, do not add it to the CV silently. Mention it in the final report so the user can decide whether to add it to the master.

## Step 3: Create application folder

```bash
mkdir -p applications/[folder_name]
```

## Step 4: Write tailored cv-content.yaml

Copy the master as the base, then tailor:

- **profile**: light touch. Reframe to the role's language and priorities. Factual only.
- **highlights**: reorder and swap to surface the most relevant wins. Max 5. Order by impact first, relevance second.
- **experience bullets**: reorder within each role to lead with the most relevant. Remove irrelevant noise. Keep the master's wording; do not invent or rewrite bullets.
- **skills tools**: reorder to lead with tools the JD mentions. Only include tools listed in the master.

Save to `applications/[folder_name]/cv-content.yaml`.

## Step 5: Write cover-letter.yaml

Structure:
```yaml
meta:
  date: [today's date, formatted as "DD Month YYYY"]
  company: [company name]
  role: [full role title]
  hiring_manager: ""

body:
  opening: [1 sentence on why this role/company, 1 sentence on what you bring]
  paragraphs:
    - [Most recent / most relevant experience mapped to role requirements]
    - [Earlier experience or technical depth, if relevant]
    - [Why this specific company: something specific from the JD, not generic]
  closing: "I'd welcome the chance to discuss how my background maps to what you're building."
```

Rules:
- No em dashes (use commas or parentheses instead)
- No hallucinations: every claim must be in the master CV (or stories)
- Always say which company a number came from
- No hollow phrases ("passionate about", "excited to", "I believe")
- 3-5 sentences per paragraph
- Direct and specific: use actual numbers and outcomes

Save to `applications/[folder_name]/cover-letter.yaml`.

## Step 6: Compile both PDFs

```bash
typst compile templates/cv-pretty.typ "applications/[folder_name]/CV.pdf" --root . --input content=/applications/[folder_name]/cv-content.yaml

typst compile templates/cover-letter.typ "applications/[folder_name]/Cover Letter.pdf" --root . --input cv=/applications/[folder_name]/cv-content.yaml --input cl=/applications/[folder_name]/cover-letter.yaml
```

Check both compile without errors. The CV must be 1 page; if it spills over, cut the least relevant bullets and recompile.

## Step 7: Open and report

```bash
open "applications/[folder_name]/CV.pdf"
open "applications/[folder_name]/Cover Letter.pdf"
```

Report:
- Folder created
- Key tailoring decisions (what changed and why)
- Honest fit assessment (what maps well, what the gaps are)
- Any claims you were unsure about
- Any achievements from stories/ or sources/ worth adding to the master CV
