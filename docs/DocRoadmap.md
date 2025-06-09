# Documentation Roadmap

This roadmap describes the steps required to document the Research Unix V10 codebase using Doxygen and Sphinx.

1. **Install Tools**
   - Ensure `doxygen`, `graphviz`, `python3-sphinx`, `tree`, and `ed` are installed via `setup.sh`.
2. **Generate Doxygen Configuration**
   - `doxygen -g docs/Doxyfile`
   - Adjust `PROJECT_NAME`, `OUTPUT_DIRECTORY`, `INPUT`, and set `RECURSIVE = YES`.
3. **Annotate Source**
   - Audit `src/` and `sys/` directories for undocumented functions or structures.
   - Add Doxygen style comments using `///` or `/** */`.
   - Correct unterminated comments and invalid includes that trigger warnings.
4. **Run Documentation Build**
   - Execute `doxygen docs/Doxyfile` and fix warnings until the build completes cleanly.
   - Use Sphinx for additional guides under `docs/`.
5. **Architecture Conversion**
   - Plan an `arch/` directory for an x86_64_v1 port, preserving original features while modernizing to C23.
6. **Continuous Integration**
   - Add documentation builds to CI workflows to catch regressions.

