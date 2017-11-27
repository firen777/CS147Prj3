# CS147Prj3
CS147Prj3

[Nov 21, 2017] Review the design for 'register_file' It has independent 'read' and 'write' signals. 'HiZ' is expected output from this module is 'read' is set to 0. To make this module work correctly with data path, keep 'read' mode on. i.e. even at write cycle control signal should be 'read=1, write=1' Otherwise you may get unexpected behavior from simulator at gate level simulation including slowness and aborting by hitting limit of eval cycle.

The primary objective of this project to write a mixed model of a bare minimum computer system DaVinci v1.0m supporting instruction set CS147DV as described in class lecture.

### Objective:

1. To implement a mixed model of a computer system with a 32-bit processor and 256MB memory (Double word (32-bit) addressable 64M address) . The processor supports the instruction set CS147DV as described in lecture 01.
    1. Processor implementation will be having two major parts.
        1. Mixed level data path implementation as discussed in class.
            1. ALU should be implemented at gate level.
            2. Register file implementation has to be done at gate level (this will -ve clock edge triggered).
            3. Memory should be in behavioral level; i.e. this module from project II can be re-used in this project.
            4. Data path should assembled at gate level - this means PC and SP registers are also to be implemented at gate level.
        2. Behavioral Control circuit implementation.  A part of control unit can be re-used from project II.
     2. To implement test for the implemented system DaVinci v1.0m.
### Outcome:

1. Fully functional processor supporting instruction set of 'CS147DV' instruction set (as in Lecture 01).
2. Fully functional 256MB memory model with data pre-loading capability.
3. Fully functional system integrating memory and the processor. We call this bare minimum computer system as DaVinci v1.0m.
4. Full testing of DaVinci v1.0m with small program using CS147DV instruction set.
5. A Project report (preferably written in IEEE format) which includes at least the following sections.
    1. Requirement for System - include  CS147DV instruction set description as well.
    2. Design and implementation of Memory.
    3. Design and implementation of Processor.
    4. Test strategy and test implementation (include text output and waveforms from simulator).
    5. Conclusion.
### Instruction:

* Download HDL source code from prj_03.zipView in a new window
    * Contains schematic for the complete data path.
    * Contains partial implementation of the processor.
    * Skeleton of all the modules to implemented is already defined. You need to fill them up.
    * Do not change module name or move them around - otherwise grading automation will be affected.
    * It is recommended to create testbench for all lower level modules and test your implementation ground up. Otherwise, at higher level issues could very complex to debug.
* Complete the source codes as required.
* Complete the test bench and any test program code / data as required.
* Create prj_03_report.pdf for report file.
* Create ZIP archive prj_03_source.zip containing all the verilog and program data file needed.
* Upload the both PDF and ZIP file [Two files to be uploaded]

==========================================================================================
# Icarus Verilog:
Installation and brief tutorial: https://www.swarthmore.edu/NatSci/mzucker1/e15_f2014/iverilog.html
