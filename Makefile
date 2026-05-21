CLAUDE_SKILLS := $(HOME)/.claude/skills

# Add more install-* targets here as new skills are added.
.PHONY: install install-visualize

install: install-visualize

install-visualize:
	@mkdir -p $(CLAUDE_SKILLS)/visualize
	@cp skills/visualize/SKILL.md $(CLAUDE_SKILLS)/visualize/SKILL.md
	@cp marshall-labs.css $(CLAUDE_SKILLS)/visualize/marshall-labs.css
	@sed '/class="ml-theme-toggle"/,/<\/button>/d' index.html \
		> $(CLAUDE_SKILLS)/visualize/example.html
	@echo "Installed: /visualize → $(CLAUDE_SKILLS)/visualize/"
