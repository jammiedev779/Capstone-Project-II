<div class="container mx-auto p-4 w-full">
    <div class="bg-white shadow overflow-hidden sm:rounded-lg">
        <div class="px-4 py-5 sm:px-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">Medical Histories</h3>
        </div>
        <div class="border-t border-gray-200">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Visit Date
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Diagnosis
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Treatment
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Note
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Follow-up Date
                        </th>
                        <th scope="col" class="relative px-6 py-3">
                            <span class="sr-only">View Prescriptions</span>
                        </th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <!--[if BLOCK]><![endif]--><?php $__currentLoopData = $medical_histories; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $history): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo e($history->visit_date); ?></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo e($history->diagnosis); ?></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo e($history->treatment); ?></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo e($history->note); ?></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo e($history->follow_up_date); ?></td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button onclick="togglePrescriptions(<?php echo e($history->id); ?>)" class="text-indigo-600 hover:text-indigo-900">View Prescriptions</button>
                            </td>
                        </tr>
                        <tr id="prescriptions-<?php echo e($history->id); ?>" class="hidden">
                            <td colspan="6" class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 bg-gray-50">
                                <div>
                                    <!--[if BLOCK]><![endif]--><?php $__currentLoopData = $history->prescription; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $prescription): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <div class="prescription mb-4">
                                            <h4 class="text-sm font-medium text-gray-900"><?php echo e($prescription->medicine_name); ?></h4>
                                            <p class="text-sm text-gray-700"><?php echo e($prescription->description); ?></p>
                                            <p class="text-sm text-gray-500">Duration: <?php echo e($prescription->duration); ?></p>
                                        </div>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?><!--[if ENDBLOCK]><![endif]-->
                                </div>
                            </td>
                        </tr>
                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?><!--[if ENDBLOCK]><![endif]-->
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php $__env->startPush('scripts'); ?>
    <script>
        function togglePrescriptions(id) {
            var element = document.getElementById('prescriptions-' + id);
            if (element.classList.contains('hidden')) {
                element.classList.remove('hidden');
            } else {
                element.classList.add('hidden');
            }
        }
    </script>
<?php $__env->stopPush(); ?>
<?php /**PATH C:\Users\vinun\Desktop\Term 7\Capstone-Project-II\Backend\resources\views//infolists/components/medical-history.blade.php ENDPATH**/ ?>