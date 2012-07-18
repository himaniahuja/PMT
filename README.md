PMT
===

Project Management Tool.

== Overview

PMT 1.1 is web version of the Project Management Tool. PMT is a product of ND System Solutions’ Software Engineering Division. Its target user group consists of managers and software developers. We are producing this product for ND Systems Solutions (NDSS) use, but we believe that others will want to purchase a product with the features we propose.

== Purpose

Software developers and project managers need tools to plan, carry out, and post-analyze their projects (to plan better for future projects). For example, they need to track planned effort on deliverables against actual effort and they need to be able to make the estimates in the first place. PET 1.1 is the initial version of a tool to support these activities. The tool was inspired in part by work done by Watts Humphrey at Carnegie Mellon University’s Software Engineering Institute on the Personal Software Process.

== Scope

Release 1.1 of the Project Management Tool, supports the ability to define new projects that use predefined lifecycles.  Project phases can have deliverables defined.  PET 1.1 makes historical production rate information available so that managers can make reasoned and defendable estimates of the effort required completing tasks of a given complexity.

NDSS is using a mixture of disciplined and agile processes to evolve the product towards its final functionality.  This document includes use cases for lifecycle management and effort logging which will be implemented in PET 1.2 and beyond. In addition, feedback from Release 1.1 will serve as a basis for improvement in future releases of the software.

== Class Diagram of PMT

<img src='class.jpg' alt='CD'>

== Design Change

At the beginning of iteration 2, we designed that each estimation has one kind of Unit. However, Units should be related to the deliverable type rather than estimation. Thus, we remove the association between Unit and Estimation, create a new one between Unit and DeliverableType.


<img src='classold.jpg' alt='CD'>
<img src='class-small.jpg' alt='CD'>
