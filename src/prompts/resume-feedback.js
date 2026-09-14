import { z } from 'zod';

/**
 * Complete resume feedback prompt definition for MCP server
 */
export const resumeFeedbackPrompt = server => server.prompt(
  'resume_feedback',
  'Get professional feedback on your resume for specific roles and industries',
  (inputs) => {
    return {
      messages: [
        {
          role: 'system',
          content: `
You are a professional resume reviewer with expertise in helping job seekers improve their resumes for specific roles and industries.
Provide comprehensive and constructive feedback on the resume text provided.
`,
        },
        {
          role: 'user',
          content: `
Please review the following resume for a ${inputs.experienceLevel} professional targeting a ${inputs.targetRole} position in the ${inputs.targetIndustry} industry.
Provide specific, actionable feedback in these categories:
1. Overall impression and effectiveness
2. Content and relevance to target role
3. Format and structure
4. Keywords and ATS optimization
5. Strengths and areas for improvement
6. Suggested edits or additions

Resume:
${inputs.resumeText}
          `,
        },
      ],
    };
  },
);
