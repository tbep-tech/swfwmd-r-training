# SWFWMD R Training Prompt Notes

Use this file to draft the longer prompt for reshaping the workshop from a beginner audience to an intermediate audience.

## Goal

The CERF workshop from which this repository was modeled was aimed at first-time R users, with several students in attendance.  This training is similar, but attendees will have some prior experience with R and will be looking to improve their R skills.  Attendees (I am expecting about 10-15) are early- to mid-career professionals from the Southwest Florida Water Management District (SWFWMD) who have some experience with R but want to learn more about data manipulation, visualization, and reproducible workflows.  The goal of this training is to build on their existing R knowledge and help them become more proficient and confident in using R for their work.  The key problem to address "we can use R scripts given to use by others (Robin Speidel), but often hit errors and cannot troubleshoot effectively". 

## Audience

- SWFWMD employees, I think most are in the [data collection bureau](https://www.swfwmd.state.fl.us/the-newsroom/data-collection).  They may be hydrologists, geologists, and engineers, probably with bachelors or masters degrees.
- They mostly use RStudio and know the basics of using R, e.g., running code, creating objects, basic data types
- We do not need to cover R basics (like we have in the template here in R_basics.qmd)

## Differences From CERF Workshop

- No need to cover R basics, i.e., we will not start from ground zero
- The examples and datasets used throughout will be specific to SWFWMD problems and representative of the types of data they work with.

## Content Changes

- Any example or exercise that used previous datasets for CERF need to use SWFWMD datasets instead.  I have access to a lot of SWFWMD datasets, so I can provide those.  These can also be accessed using SWFWMD's data portal, which is a REST API where URLs are sent to request and retrieve data seamlessly.  I have a script showing some examples.  It would be useful to work this into the training, e.g., show some examples in the first module for how to retrieve data from the portal, and then use that data for the exercises in the later modules.  Examples of this are at R/Training-Marcus_Beck.R
- Perhaps replace the R basics section with setup for the day, e.g., a project-oriented workflow (e.g., using RStudio projects, absolute vs relative paths, modularity, folder structure, best practices for writing code, etc.), tips for getting help, AI usage
- New topics to add - I need to expand on the section about generative AI, primarily how it can be used to troubleshoot code, i.e., if I don't know what a script does, just drop it into a chat with an AI and ask it to explain.  It can give you detailed step by step explanations.  It can also help you troubleshoot code, e.g., if you have an error message, you can drop the code and error into an AI and ask it to help you fix the error.  But also focus on the drawbacks, it can quickly get away from you if you are using it to generate code. Emphasis should be on learning the fundamentals. 
- There are several examples that use generic datasets that are built into R or the tidyverse to demonstrate core data wrangling principles.  These should remain as the example datasets very clearly show the example problem being addressed.  The same principles can be extended to the SWFWMD datasets once the core principles are explained with the simpler datasets.  These simple examples and simple datasets should be retained. The data analysis workflow described in R for Data Science is a central theme of these teaching materials that can be exemplified with the SWFWMD datasets.

## Data And Domain Context

As noted above, I have examples of how to retrieve SWFWMD data that we can use to bound the examples.  However, I will need to review the datasets and determine which ones are most appropriate for the exercises.  I will also need to provide some context for the datasets, e.g., what they represent, how they were collected, what types of analyses are commonly performed with them, etc.  This will help make the examples more relevant and engaging for the participants.  Modifying them to work with the key examples herein (e.g., joining, summarized, plotting, etc.) is key. 

## Tone And Teaching Style

The workshop is a mix of instructor led demonstrations where attendees follow along with me, then apply the same concepts in independent exercises.  The tone should be friendly and supportive, encouraging attendees to ask questions and engage with the material.  The teaching style should be hands-on and interactive, with plenty of opportunities for attendees to practice what they are learning. 

## Constraints

The general structure of the workshop and book should be retained, but I am looking for ideas on how to better suit the needs of this audience.  This will require me to update the examples and dataset to use SWFWMD datasets instead of the previous CERF datasets. Tailoring the content to a more intermediate audience will also be needed, primarily removing the "R basics" content and replacing it with more appropriate content like project-oriented workflows, getting help, etc. as outlined above.  I also realize that "intermediate" is subjective and much of the core content already present could probably remain as is, but updated accordingly with SWFWMD data and examples. More advanced topics like functions and looping may not be appropriate, but it would be useful to showcase examples of "large-scale" data manipulation to showcase the power of R.  For example, the dplyr -> group_by -> summarize workflow combined with time series date manipulations via lubridate maybe particularly compelling.  I think I have some examples of this already, but keep this kind of thing in mind when crafting examples.

Also, see the image at figs\swfwmd_r_ideas.png for a screenshot of two emails from SWFWMD staff indicatings topics to cover.  These topics alone would be a weeks worth of training, but there may be some elements in here to consider given the context above.  

## Step-by-step Rework Roadmap

The repo can be reworked as a staged adaptation rather than a full rewrite.

1. Reframe the book-level narrative so the course is for attendees who can already run R code but want to understand, adapt, and troubleshoot scripts more confidently.
2. Replace `R_basics.qmd` with `R_overview.qmd` and use it to set the tone for the rest of the workshop.
3. Build the first lesson around project-oriented workflow rather than beginner syntax, with emphasis on:
   - working in RStudio projects
   - file paths, folder structure, and reproducibility
   - reading and understanding inherited scripts
   - accessing SWFWMD data from the portal
   - getting help and troubleshooting errors
   - using AI to explain and troubleshoot code without replacing fundamentals
4. Choose one anchor SWFWMD dataset or workflow that can connect the wrangling, visualization, and spatial modules.
5. Rework `data_wrangling_1.qmd` around core transformations, keeping simple built-in examples where they teach the principle clearly and then bridging to SWFWMD data.
6. Rework `data_wrangling_2.qmd` around realistic joins, tidy data, grouped summaries, and date workflows using SWFWMD-style datasets.
7. Rework `data_viz.qmd` and `spatial_data_analysis.qmd` after the main data pipeline is settled.
8. Update supporting pages such as `index.qmd`, `setup.qmd`, `data_resources.qmd`, and `_quarto.yml` after the lesson structure is stable.

## First Module Direction: `R_overview`

The opening module should move participants from "I can run code" to "I can understand, organize, adapt, and troubleshoot code."

Suggested sections:

- Goals and framing
- Why this training is different from a beginner workshop
- Project-oriented workflow in RStudio
- Reproducible file organization and relative paths
- Working with scripts from colleagues
- Accessing SWFWMD data from the portal
- Troubleshooting and getting help
- Using AI as a support tool, not a substitute
- Exercise: create a project and organize folders
- Exercise: retrieve or inspect a dataset and understand its structure
- Exercise: run and debug a short inherited script

## Draft Prompt

Given the above, provide some ideas of how to proceed for updating this workshop. 
